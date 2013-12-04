Snowflake::Admin.controllers :parks do
  get :index do
    @title = "Parks"
    @parks = Park.all
    render 'parks/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'park')
    @park = Park.new
    render 'parks/new'
  end

  post :create do
    @park = Park.new(params[:park])
    if @park.save
      @title = pat(:create_title, :model => "park #{@park.id}")
      flash[:success] = pat(:create_success, :model => 'Park')
      params[:save_and_continue] ? redirect(url(:parks, :index)) : redirect(url(:parks, :edit, :id => @park.id))
    else
      @title = pat(:create_title, :model => 'park')
      flash.now[:error] = pat(:create_error, :model => 'park')
      render 'parks/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "park #{params[:id]}")
    @park = Park.get(params[:id])
    if @park
      render 'parks/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'park', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "park #{params[:id]}")
    @park = Park.get(params[:id])
    if @park
      if @park.update(params[:park])
        flash[:success] = pat(:update_success, :model => 'Park', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:parks, :index)) :
          redirect(url(:parks, :edit, :id => @park.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'park')
        render 'parks/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'park', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Parks"
    park = Park.get(params[:id])
    if park
      if park.destroy
        flash[:success] = pat(:delete_success, :model => 'Park', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'park')
      end
      redirect url(:parks, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'park', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Parks"
    unless params[:park_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'park')
      redirect(url(:parks, :index))
    end
    ids = params[:park_ids].split(',').map(&:strip)
    parks = Park.all(:id => ids)
    
    if parks.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Parks', :ids => "#{ids.to_sentence}")
    end
    redirect url(:parks, :index)
  end
end
