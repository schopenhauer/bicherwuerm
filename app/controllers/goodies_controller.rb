class GoodiesController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def statistics
    @genres = Book.group(:genre).count.map { |k, v| [safe_name(k), v] }.rank_by_count
    @categories = Book.group(:category).count.map { |k, v| [safe_name(k), v] }.rank_by_count
    @publishers = Book.group(:publisher).count.map { |k, v| [safe_name(k), v] }.rank_by_count
    @users = Book.group(:user).count.map { |k, v| [safe_name(k), v] }.rank_by_count
    @authors = Book.group(:author).count.map { |k, v| [k, v] }.rank_by_count
    @colors = Book.group(:color).count.map { |k, v| [safe_name(k), v] }.rank_by_count
  end

  private

  def safe_name(k)
    k.nil? ? 'Unknown' : k.name
  end

end

class Array
  def rank_by_count
    sort_by { |x| x[1] }.reverse
  end
end
