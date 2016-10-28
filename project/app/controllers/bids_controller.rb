class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :approve]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)

    respond_to do |format|
      if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.delete
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    Bid.pickup_bid(@paramss[0], @paramss[1], @paramss[2])
    redirect_to stuffs_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @paramss = params[:id].split(',')
      @bid = Bid.get_bid(@paramss[0], @paramss[1], @paramss[2])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params[:bid][:bidder_username] = current_user.username
      params.require(:bid).permit(:stuff_create_time, :owner_username, :bidder_username, :bidding_points, :status, :create_time)
    end
end
