Snowflake::Admin.controllers :roads do
  get :index do
    @title = "Roads"
    @roads = Road.all
    render 'roads/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'road')
    @road = Road.new
    render 'roads/new'
  end

  post :create do
    @road = Road.new(params[:road])
    if @road.save
      @title = pat(:create_title, :model => "road #{@road.id}")
      flash[:success] = pat(:create_success, :model => 'Road')
      params[:save_and_continue] ? redirect(url(:roads, :index)) : redirect(url(:roads, :edit, :id => @road.id))
    else
      @title = pat(:create_title, :model => 'road')
      flash.now[:error] = pat(:create_error, :model => 'road')
      render 'roads/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "road #{params[:id]}")
    @road = Road.get(params[:id])
    if @road
      render 'roads/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'road', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "road #{params[:id]}")
    @road = Road.get(params[:id])
    if @road
      if @road.update(params[:road])
        flash[:success] = pat(:update_success, :model => 'Road', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:roads, :index)) :
          redirect(url(:roads, :edit, :id => @road.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'road')
        render 'roads/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'road', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Roads"
    road = Road.get(params[:id])
    if road
      if road.destroy
        flash[:success] = pat(:delete_success, :model => 'Road', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'road')
      end
      redirect url(:roads, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'road', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Roads"
    unless params[:road_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'road')
      redirect(url(:roads, :index))
    end
    ids = params[:road_ids].split(',').map(&:strip)
    roads = Road.all(:id => ids)
    
    if roads.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Roads', :ids => "#{ids.to_sentence}")
    end
    redirect url(:roads, :index)
  end
end
