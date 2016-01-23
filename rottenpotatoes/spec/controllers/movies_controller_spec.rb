require 'spec_helper'
require 'rails_helper'

describe MoviesController do
    describe 'find movies whose director matches that of the current movie' do
        it 'click on link should call :by_director on Movie model' do
            Movie.should_receive(:by_director).with('1')
            get :director, {:movie_id => '1'}
        end
        
        describe 'return movies with the same director' do
            it 'should set the list of movies' do
                movie1 = FactoryGirl.build(:movie, {:title => '1', :director => 'myself'})
                movie2 = FactoryGirl.build(:movie, {:title => '2', :director => 'myself'})
                movies_list = [movie1, movie2]
                Movie.stub(:current_movie).and_return(movie1)
                Movie.stub(:movies_with_director).and_return(movies_list)
                get :director, {:movie_id => '1'}
                assigns(:movies).should == movies_list
            end
        end
        
        describe 'when director is missing from the current movie' do
            it 'should redirect to index' do
                movie = FactoryGirl.build(:movie)
                Movie.stub(:current_movie).and_return(movie)
                get :director, {:movie_id => '1'}
                response.should redirect_to :movies
            end
        end
    end
    
    describe "show movies" do
        it "should open the home page" do
            get :index
            assigns(:movies)
        end
    end
    
    
    describe "delete movie" do
        it "should get to controller and redirect" do
            movie1 = FactoryGirl.build(:movie, {:title => '123', :director => 'myself'})
            Movie.stub(:find).and_return(movie1)
            delete :destroy, {:id => '1'}
            response.should redirect_to :movies
        end
    end
    
    describe "update movie" do
        let(:attr) do
            # params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
            { :title => 'a' }
        end
        it "should get to controller and redirect" do
            movie1 = FactoryGirl.build(:movie, {:title => '123', :director => 'myself'})
            Movie.stub(:find).and_return(movie1)
            put :update, :id => '1', :movie => attr
            response.should redirect_to "/movies/1"
        end
    end
    
    describe "movie create" do
        let(:attr) do
            # params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
            { :title => 'a', :ratting => "R", :description => "asdf" }
        end
        it "should get to controller and redirect" do
            movie1 = FactoryGirl.build(:movie, attr)
            Movie.stub(:create).and_return(movie1)
            post :create, :movie => attr
            response.should redirect_to :movies
        end
    end
    
end
    