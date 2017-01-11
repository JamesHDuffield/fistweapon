require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "should only save if has a name" do
    member = Member.new
    assert !member.save
  end

  test "should return correct icon url" do
    member = Member.new
    member.icon = "hunter02"
    assert_equal member.spec_url, "http://media.blizzard.com/wow/icons/56/hunter02.jpg"
  end

  test "should return correct ask mr robot link" do
    member = Member.new
    member.name = "Fuseloose"
    assert_equal member.ask_mr_robot, "http://www.askmrrobot.com/wow/gear/us/barthilas/Fuseloose"
  end
end
