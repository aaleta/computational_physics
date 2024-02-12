#include <stdio.h>
#include <stdlib.h>
#include "parisi.h"
#include "pokemon_data.h"

#define MAXPROBABILITY ((pokemon.catch_rate + 1)/(ball_modifier[pokeball_id] + 1))

float captureProbability(int current_health, int max_health, int catch_rate, int ball_modifier);
void Histogram(int *data, double *Hist, int N_data, int N_intervalos, 
                double *delta, double *minimo, double *maximo);

int main() {
    /* Pokemon variables */
    int i, pokemon_id, min_health, max_health, health, pokeball_id;
    int *captured_pokemon_health, n_captured;
    double y;
    Pokemon pokemon;
    /* Histogram variables */
    double *histogram, histogram_min, histogram_max, histogram_delta;
    int n_histogram_bins;
    FILE *f;

    /* Set variables */
    pokemon_id = Bulbasaur;
    n_captured = 100000;
    pokeball_id = PokeBall;

    /* Initialization */
    iniRandomParisi(123);
  
    pokemon = pokemon_data[pokemon_id];
    min_health = 1;
    max_health = pokemon.max_health;
    captured_pokemon_health = malloc(n_captured * sizeof *captured_pokemon_health);

    /* 
        Implement here a rejection sampling algorithm
        to estimate the health with which each Pokémon
        was captured and store it in captured_pokemon_health.
    */
    for(i = 0; i < n_captured; i++) {

    }
    
    /* Compute the histogram */
    n_histogram_bins = max_health - min_health;
    histogram = malloc(n_histogram_bins * sizeof *histogram);

    Histogram(captured_pokemon_health, histogram, n_captured, n_histogram_bins, &histogram_delta, &histogram_min, &histogram_max);

    f = fopen("histogram.txt", "w");
    for(i = 0; i < n_histogram_bins; i++) {
        fprintf(f,"%lf %lf\n", histogram_min + histogram_delta * i, histogram[i]);
    }
    fclose(f);

    /* Clean-up */
    free(captured_pokemon_health);
    free(histogram);
}

void Histogram(int *data, double *Hist, int N_data, int N_intervalos,
                double *delta, double *minimo, double *maximo)
{

}


float captureProbability(int current_health, int max_health, int catch_rate, int ball_modifier) {
    int f_factor;
    float probability;

    f_factor = (max_health * 255 * 4) / (current_health * ball_modifier);
    f_factor = f_factor>255?255:f_factor;

    probability = (catch_rate + 1) * (f_factor + 1) / ((ball_modifier + 1) * 256);

    return probability;
}

float randomParisi(void)
{
  float r;

  ig1 = ind_ran - 24;
  ig2 = ind_ran - 55;
  ig3 = ind_ran - 61;
  irr[ind_ran] = irr[ig1] + irr[ig2];
  ir1 = (irr[ind_ran]^irr[ig3]);
  ind_ran++;
  r = ir1*NormRANu;

  return r;
}

void iniRandomParisi(int semilla)
{
  int INI,FACTOR,SUM,i;

  srand(semilla);

  INI = semilla;
  FACTOR = 67397;
  SUM = 7364893;

  for(i=0;i<256;i++)
    {
      INI = INI*FACTOR+SUM;
      irr[i] = INI;
    }
  ind_ran = ig1 = ig2 = ig3 = 0;
}