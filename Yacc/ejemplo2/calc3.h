#define MAX_SIM 20 /*numero maximo de simbolos para la tabla*/

struct simbolo {
    char   *nombre;
    double valor;
}tabla_simbolos[MAX_SIM];

struct simbolo *buscar_simbolo();
