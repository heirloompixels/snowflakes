Snowflake::Admin.controllers :reports do
  get :index do
    @title = "Reports"
    @reports = Report.all(:order => [ :id.desc ])
    render 'reports/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'report')
    if Report.last
      @report = Report.last
    else
      @report = Report.new
    end
    render 'reports/new'
  end

  post :create do
    @report = Report.new(params[:report])
    if @report.save
      @title = pat(:create_title, :model => "report #{@report.id}")
      flash[:success] = pat(:create_success, :model => 'Report')
      params[:save_and_continue] ? redirect(url(:reports, :index)) : redirect(url(:reports, :edit, :id => @report.id))
    else
      @title = pat(:create_title, :model => 'report')
      flash.now[:error] = pat(:create_error, :model => 'report')
      render 'reports/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "report #{params[:id]}")
    @report = Report.get(params[:id])
    if @report
      render 'reports/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'report', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "report #{params[:id]}")
    @report = Report.get(params[:id])
    if @report
      if @report.update(params[:report])
        flash[:success] = pat(:update_success, :model => 'Report', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:reports, :index)) :
          redirect(url(:reports, :edit, :id => @report.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'report')
        render 'reports/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'report', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Reports"
    report = Report.get(params[:id])
    if report
      if report.destroy
        flash[:success] = pat(:delete_success, :model => 'Report', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'report')
      end
      redirect url(:reports, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'report', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Reports"
    unless params[:report_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'report')
      redirect(url(:reports, :index))
    end
    ids = params[:report_ids].split(',').map(&:strip)
    reports = Report.all(:id => ids)

    if reports.destroy

      flash[:success] = pat(:destroy_many_success, :model => 'Reports', :ids => "#{ids.to_sentence}")
    end
    redirect url(:reports, :index)
  end
end
