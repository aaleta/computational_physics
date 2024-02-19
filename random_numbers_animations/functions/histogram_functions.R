get_box = function(x, min_number, delta_hist)
{
	return(ceiling((x - min_number) / delta_hist))
} 

create_histogram = function(x, min_number, max_number, delta_hist, step = 1)
{
	box = get_box(x, min_number, delta_hist)

	histogram = data.frame(x = seq(min_number, max_number, by = delta_hist))
	histogram$y = 0
	histogram$y[box] = 1

	histogram$color = "inactive"
	histogram$color[box] = "active"

	histogram$step = step

	return(histogram)
}

update_histogram = function(previous_histogram, x, min_number, delta_hist, step, interpolation)
{
	box = get_box(x, min_number, delta_hist)

	previous_histogram$y[box] = previous_histogram$y[box] + 1
	
	previous_histogram$color = "inactive"
	previous_histogram$color[box] = "active"

	previous_histogram$step = step * interpolation

	return(previous_histogram)
}
