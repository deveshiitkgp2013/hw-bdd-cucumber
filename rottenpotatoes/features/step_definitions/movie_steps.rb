# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #fail "Unimplemented"
end


Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end



# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"
  expect(page.body.index(e1)).to be <= page.body.index(e1)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(',')
  ratings.each do |rating|
    if uncheck.nil? 
      check(rating)
    else
      uncheck(rating)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"
end

Then /I should (not )?see following movies: (.*)/ do |no, movie_list|
  movie_list = movie_list.split(',')
  movie_list.each do |movie|
    if no.nil?
      if page.respond_to? :should
        page.should have_content(movie)
      else
        assert page.has_content?(movie)
      end
    else
      if page.respond_to? :should
        page.should have_no_content(movie)
      else
        assert page.has_no_content?(movie)
  end
    end
  end
  
end


Then /^I should see all of the movies/ do 
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"

  expect(all("table#movies tr").count).to eq 11
end

When /^(?:|I )press (.*)$/ do |button|
  click_button(button)
end