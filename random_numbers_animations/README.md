# Random numbers and the Metropolis algorithm

These codes will create the animations shown in the *videos* folder to facilitate the understanding of the Metropolis-Hastings algorithm[^1].

- Uniform changes: selects numbers randomly between -10 and 10, obtaining a flat distribution.

- Little changes: each new number, $x$, is chosen close to the previous one, $y$. For simplicity, instead of selecting the new candidate following the usual Gaussian distribution, the new value follows a (narrow) uniform distribution centered around $y$.

- Metropolis changes: new candidates are selected using the same procedure, but their acceptance depends on the acceptance ratio $\alpha = \exp(-20(x^2-y^2))$ following Metropolis algorithm.

Note that to speed up the process, instead of using the official gganimate implementation, the code assumes you have the parallel version proposed by Henrik Bengtsson[^2]. If you don't, it will simply take longer but it should work the same.


[^1]: https://en.wikipedia.org/wiki/Metropolis%E2%80%93Hastings_algorithm#Intuition
[^2]: https://github.com/thomasp85/gganimate/pull/403
