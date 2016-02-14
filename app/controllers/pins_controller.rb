class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all
  end
  #Number 7, the only one not related to the four basic resource actions
  
  def show
  end
  # Takes you to pin page/shows you the pin

  def new
    @pin = current_user.pins.build
  end
  # This creates/redirects to or whatever to the 'new pin' site


  def edit
  end

  #Takes you to edit page?


  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
     render :new 
   end

  end
  # new + create -> Creates new pin when you click 'create' under 'new pin'

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render :edit
    end
  end
  # Edits the pin

  def destroy
    @pin.destroy
      redirect_to pins_url, notice: 'Pin was successfully destroyed.'
  end

  # destroys a pin

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "You are not authorized to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
