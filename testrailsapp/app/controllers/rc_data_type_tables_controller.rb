class RcDataTypeTablesController < ApplicationController
  # GET /rc_data_type_tables
  # GET /rc_data_type_tables.json
  def index
    @rc_data_type_tables = RcDataTypeTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rc_data_type_tables }
      format.xml  { render xml:  @rc_data_type_tables }
    end
  end

  # GET /rc_data_type_tables/1
  # GET /rc_data_type_tables/1.json
  def show
    @rc_data_type_table = RcDataTypeTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rc_data_type_table }
    end
  end

  # GET /rc_data_type_tables/new
  # GET /rc_data_type_tables/new.json
  def new
    @rc_data_type_table = RcDataTypeTable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rc_data_type_table }
    end
  end

  # GET /rc_data_type_tables/1/edit
  def edit
    @rc_data_type_table = RcDataTypeTable.find(params[:id])
  end

  # POST /rc_data_type_tables
  # POST /rc_data_type_tables.json
  def create
    @rc_data_type_table = RcDataTypeTable.new(params[:rc_data_type_table])

    respond_to do |format|
      if @rc_data_type_table.save
        format.html { redirect_to @rc_data_type_table, notice: 'Rc data type table was successfully created.' }
        format.json { render json: @rc_data_type_table, status: :created, location: @rc_data_type_table }
      else
        format.html { render action: "new" }
        format.json { render json: @rc_data_type_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rc_data_type_tables/1
  # PUT /rc_data_type_tables/1.json
  def update
    @rc_data_type_table = RcDataTypeTable.find(params[:id])

    respond_to do |format|
      if @rc_data_type_table.update_attributes(params[:rc_data_type_table])
        format.html { redirect_to @rc_data_type_table, notice: 'Rc data type table was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rc_data_type_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rc_data_type_tables/1
  # DELETE /rc_data_type_tables/1.json
  def destroy
    @rc_data_type_table = RcDataTypeTable.find(params[:id])
    @rc_data_type_table.destroy

    respond_to do |format|
      format.html { redirect_to rc_data_type_tables_url }
      format.json { head :ok }
    end
  end
end
