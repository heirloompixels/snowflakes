Snowflake::Admin.controllers :trails do
  get :index do
    @title = "Trails"
    @trails = Trail.all
    render 'trails/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'trail')
    @trail = Trail.new
    render 'trails/new'
  end

  post :create do
    @trail = Trail.new(params[:trail])
    if @trail.save
      @title = pat(:create_title, :model => "trail #{@trail.id}")
      flash[:success] = pat(:create_success, :model => 'Trail')
      params[:save_and_continue] ? redirect(url(:trails, :index)) : redirect(url(:trails, :edit, :id => @trail.id))
    else
      @title = pat(:create_title, :model => 'trail')
      flash.now[:error] = pat(:create_error, :model => 'trail')
      render 'trails/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "trail #{params[:id]}")
    @trail = Trail.get(params[:id])
    if @trail
      render 'trails/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'trail', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "trail #{params[:id]}")
    @trail = Trail.get(params[:id])
    if @trail
      if @trail.update(params[:trail])
        flash[:success] = pat(:update_success, :model => 'Trail', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:trails, :index)) :
          redirect(url(:trails, :edit, :id => @trail.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'trail')
        render 'trails/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'trail', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Trails"
    trail = Trail.get(params[:id])
    if trail
      if trail.destroy
        flash[:success] = pat(:delete_success, :model => 'Trail', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'trail')
      end
      redirect url(:trails, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'trail', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Trails"
    unless params[:trail_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'trail')
      redirect(url(:trails, :index))
    end
    ids = params[:trail_ids].split(',').map(&:strip)
    trails = Trail.all(:id => ids)
    
    if trails.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Trails', :ids => "#{ids.to_sentence}")
    end
    redirect url(:trails, :index)
  end
end
