class MoviesController < ApplicationController
    
    def index
        @movies = Movie.all
    end 
    
    def show
         @movie = Movie.find_by_id(params[:id]) # what if this movie not in DB?
        # BUG: we should check @movie for validity here!
    end
    
    def new
        # default: render 'new' template
    end
    
    def create
        @movie = Movie.create!(movie_params)
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movies_path
    end
    
    def edit
        @movie = Movie.find params[:id]
    end
 
    
    def update
        @movie = Movie.find params[:id]
        @movie.update_attributes!(movie_params)
        respond_to do |client_wants|
            client_wants.html {  redirect_to movie_path(@movie)  } # as before
            client_wants.xml  {  render :xml => @movie.to_xml    }
        end
    end
    
    #def update
    #    @movie = Movie.find params[:id]
    #    @movie.update_attributes!(movie_params)
    #    flash[:notice] = "#{@movie.title} was successfully updated."
    #    redirect_to movie_path(@movie)
    #end
    
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end
    
    private
    def movie_params
        params.require(:movie).permit!
    end
end
