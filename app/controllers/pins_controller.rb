# frozen_string_literal: true

class PinsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_pin, only: %i[show edit update destroy]
  before_action :set_story, only: %i[create]

  # GET /pins or /pins.json
  def index
    @pins = Pin.all
  end

  # GET /pins/1 or /pins/1.json
  def show; end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit; end

  # POST /pins or /pins.json
  def create
    @pin = Pin.new(pin_params)
    @pin.save # TODO: split into error handling
  end

  # PATCH/PUT /pins/1 or /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin.story, notice: I18n.t('pins.notices.successfully_updated') }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1 or /pins/1.json
  def destroy
    @pin.destroy

    respond_to do |format|
      format.html { redirect_to @pin.story, notice: I18n.t('pins.notices.successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pin
    @pin = Pin.find(params[:id])
  end

  def set_story
    @story = Story.find(params[:pin][:story_id])
  end

  # Only allow a list of trusted parameters through.
  def pin_params
    params.require(:pin).permit(:story_id, :comment_id)
  end
end
