ellipse_radius = function(a, b, angle)
{
	num = a * b
	den = sqrt((b * cos(angle)) ** 2 + (a * sin(angle)) ** 2)
	return(num / den)
}

create_elliptic_path = function(start_point, end_point, n_points, ellipse_b, step, lower_limit, upper_limit)
{
	if(end_point > start_point) {
		ellipse_a = (end_point - start_point) / 2.0
		x0 = start_point + ellipse_a
		angles = seq(pi, 0, length.out = n_points)
	} else {
		ellipse_a = (start_point - end_point) / 2.0
		x0 = start_point - ellipse_a
		angles = seq(0, pi, length.out = n_points)
	}

	x = x0 + ellipse_radius(ellipse_a, ellipse_b, angles) * cos(angles)
	y = ellipse_radius(ellipse_a, ellipse_b, angles) * sin(angles)

	x[x > upper_limit] = lower_limit + x[x > upper_limit] - upper_limit
	x[x < lower_limit] = upper_limit + x[x < lower_limit] - lower_limit

	points = data.frame(x = x, y = y, step = ((step - 1) * n_points + 1):(step * n_points))
	return(points)
}
