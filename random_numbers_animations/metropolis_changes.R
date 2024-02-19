library(gganimate)
source("functions/generate_data_metropolis.R")
source("functions/plot_points.R")
source("functions/plot_histogram.R")

# Configure animation
steps = 2000
interpolation = 10
delta_hist = 0.1
future::plan("multicore", workers = 50)

# Create data
animation_data = generate_data(steps = steps, delta_hist = delta_hist)

points = animation_data[[1]]
histograms = animation_data[[2]]

# Plot animations
p = plot_points(points)
animate(p, nframes = steps * interpolation, duration = steps / 10, renderer = ffmpeg_renderer(), width = 800, height = 300)
anim_save('metropolis_ball.mp4', animation = last_animation())

p = plot_histograms(histograms, steps, delta_hist = delta_hist, type = "metropolis")
animate(p, nframes = steps * interpolation, duration = steps / 10, renderer = ffmpeg_renderer(), width = 800, height = 300)
anim_save('metropolis_histogram.mp4', animation = last_animation())

# Afterwards, to paste them:
system("ffmpeg -i metropolis_ball.mp4 -i metropolis_histogram.mp4 -filter_complex vstack metropolis_complete.mp4")


