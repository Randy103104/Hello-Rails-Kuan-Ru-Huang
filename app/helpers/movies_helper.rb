module MoviesHelper
   # Helper to generate sortable column links
   def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }
  end
end
