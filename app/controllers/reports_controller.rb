class ReportsController < ApplicationController
  def members_list
	   if params[:term]
       like= "%".concat(params[:term].concat("%"))
       users = Member.where("name like ?", like)
     else
       users = Member.all
     end
     list = users.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
     render json: list
  end

  def new
    @members = Member.order('name').all

  end

  def create
  end
end
