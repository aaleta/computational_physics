library(gganimate)
source("functions/generate_data.R")
source("functions/plot_points.R")
source("functions/plot_histogram.R")

# Configure animation
steps = 500
interpolation = 10
future::plan("multicore", workers = 20)

# Create data
animation_data = generate_data(steps = steps)

points = animation_data[[1]]
histograms = animation_data[[2]]

# Plot animations
p = plot_points(points)
#animate(p, nframes = steps * interpolation, duration = steps / 10, renderer = ffmpeg_renderer(), width = 800, height = 300)
#anim_save('uniform_ball.mp4', animation = last_animation())

p = plot_histograms(histograms, steps)
animate(p, nframes = steps * interpolation, duration = steps / 10, renderer = ffmpeg_renderer(), width = 800, height = 300)
anim_save('uniform_histogram.mp4', animation = last_animation())

# Afterwards, to paste them:
system("ffmpeg -i uniform_ball.mp4 -i uniform_histogram.mp4 -filter_complex vstack uniform_complete.mp4")


