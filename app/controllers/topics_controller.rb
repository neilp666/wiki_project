class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :show]

  def index
    @topics = Programming_Topic.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
    @programming_topic_articles = @programming_topic_articles.all
  end

  def set_topic
    @topics = Programming_Topic.find(params[:id])
  end
end
