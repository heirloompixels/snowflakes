Snowflake::Admin.controllers :lifts do
  get :index do
    @title = "Lifts"
    @lifts = Lift.all
    render 'lifts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'lift')
    @lift = Lift.new
    render 'lifts/new'
  end

  post :create do
    @lift = Lift.new(params[:lift])
    if @lift.save
      @title = pat(:create_title, :model => "lift #{@lift.id}")
      flash[:success] = pat(:create_success, :model => 'Lift')
      params[:save_and_continue] ? redirect(url(:lifts, :index)) : redirect(url(:lifts, :edit, :id => @lift.id))
    else
      @title = pat(:create_title, :model => 'lift')
      flash.now[:error] = pat(:create_error, :model => 'lift')
      render 'lifts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "lift #{params[:id]}")
    @lift = Lift.get(params[:id])
    if @lift
      render 'lifts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'lift', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "lift #{params[:id]}")
    @lift = Lift.get(params[:id])
    if @lift
      if @lift.update(params[:lift])
        flash[:success] = pat(:update_success, :model => 'Lift', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:lifts, :index)) :
          redirect(url(:lifts, :edit, :id => @lift.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'lift')
        render 'lifts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'lift', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Lifts"
    lift = Lift.get(params[:id])
    if lift
      if lift.destroy
        flash[:success] = pat(:delete_success, :model => 'Lift', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'lift')
      end
      redirect url(:lifts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'lift', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Lifts"
    unless params[:lift_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'lift')
      redirect(url(:lifts, :index))
    end
    ids = params[:lift_ids].split(',').map(&:strip)
    lifts = Lift.all(:id => ids)
    
    if lifts.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Lifts', :ids => "#{ids.to_sentence}")
    end
    redirect url(:lifts, :index)
  end
end
