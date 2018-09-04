require "rails_helper"

RSpec.feature "Editing Exercises" do 

  before do
    @owner = User.create(email: "owner@example.com", password: "password")

    @owner_exer = @owner.exercises.create!(duration_in_min: 45,
      workout: "Cardio Activity",
      workout_date: "2018-09-06")

    login_as(@owner)
  end

  scenario "with valid inputs secceeds" do
    visit "/"
    click_link "My Lounge"
    link = "a[href='/users/#{@owner.id}/exercises/#{@owner_exer.id}/edit']"

    find(link).click
    fill_in "Duration", with: 50
    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(50)
    expect(page).not_to have_content(45)
  end
end