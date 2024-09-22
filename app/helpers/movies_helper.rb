module MoviesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    # Fetch the current sorting direction
    direction = (column == session[:sort] && session[:direction] == 'asc') ? 'desc' : 'asc'
    # Generate the link with the correct sorting direction
    link_to title, movies_path(sort: column, direction: direction), class: "sortable #{highlight_column(column)}"
  end

  def highlight_column(column)
    # Highlight the currently sorted column
    if column == session[:sort]
      session[:direction] == 'asc' ? 'sort-asc' : 'sort-desc'
    end
  end

  # No need to toggle direction unnecessarily. Just fetch the current direction.
  def sort_direction(column)
    column == session[:sort] ? session[:direction] : 'asc'
  end
end


