Given(/^the following movies exist:$/) do |movies_table|
  # table is a Cucumber::Ast::Table
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then(/^the director of "(.+)" should be "(.+)"$/) do |movie_title, director|
  movie = Movie.where('title = :title', :title => movie_title).first
  movie.director == director
end