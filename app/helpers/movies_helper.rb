module MoviesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }, class: "sortable #{'sort-asc' if sort_direction == 'asc'} #{'sort-desc' if sort_direction == 'desc'}"
  end

  def highlight_column(column)
    # Highlight the currently sorted column using sort_column and sort_direction
    if column == sort_column
      sort_direction == "asc" ? "sort-asc" : "sort-desc"
    end
  end

  def sort_column
    session[:sort] || "title" # Default to 'title' if nothing in session
  end

  def sort_direction
    session[:direction] || "asc" # Default to 'asc' if nothing in session
  end
end
