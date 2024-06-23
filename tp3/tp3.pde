//Aleksakhina Diana
//comision 1 tp3

//Profesor, quería explicar por qué no pude cumplir con la tarea de grabar un video.
//Me enfrento a serias dificultades psicológicas al grabar videos, lo cual me genera mucha ansiedad y preocupación.
//Esto me impide presentar el material de manera efectiva y demostrar mis conocimientos.
//Me gustaría mucho mostrar mi trabajo y estoy dispuesta a considerar otras formas alternativas, como explicarlo por escrito en lugar de hacer un video.
//Agradezco mucho su comprensión y apoyo en este asunto.


import processing.core.PImage;

// Declare a variable to hold the image
PImage img;

// Defino la cantidad de filas y columnas
int filas = 20;
int columnas = 20;

// Arreglos para almacenar los diámetros originales y actuales de los círculos
float[] diametrosOriginales;
float[] diametrosActuales;

// Variable para detener el movimiento de los círculos
boolean detenerMovimiento = false;

// Coeficientes de escala
float escala = 1.2;
float factorReduccion = 0.8;

void setup() {
  size(800, 400);  // Establezco el tamaño de la ventana
  
  // Cargar la imagen desde la carpeta de datos del proyecto
  img = loadImage("noname.jpg");
  
  // Establezco el color de fondo
  background(112, 117, 120);
  
  // Calculo el tamaño de los círculos
  float tamañoCirculo = height / filas;
  
  // Inicializo los arreglos para los tamaños de los círculos
  diametrosOriginales = new float[filas * columnas];
  diametrosActuales = new float[filas * columnas];
  
  // Comienzo a dibujar los círculos
  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      float x = width / 2 + i * tamañoCirculo + tamañoCirculo / 2;
      float y = j * tamañoCirculo + tamañoCirculo / 2;
      
      // Calculo el diámetro del círculo según su posición
      float diametro;
      if (i == 0) {
        // Si es la primera columna (izquierda)
        if ((i + j) % 2 == 0) {
          // Los círculos blancos aumentan de arriba hacia abajo
          diametro = tamañoCirculo * escala * (1 - j / float(filas)) * factorReduccion;
        } else {
          // Los círculos negros disminuyen de arriba hacia abajo
          diametro = tamañoCirculo * escala * (j / float(filas)) * factorReduccion;
        }
      } else if (i == columnas - 1) {
        // Si es la última columna (derecha)
        if ((i + j) % 2 == 0) {
          // Los círculos blancos aumentan de arriba hacia abajo
          diametro = tamañoCirculo * escala * (j / float(filas)) * factorReduccion;
        } else {
          // Los círculos negros disminuyen de arriba hacia abajo
          diametro = tamañoCirculo * escala * (1 - j / float(filas)) * factorReduccion;
        }
      } else if (j == 0) {
        // Si es la primera fila (arriba)
        if ((i + j) % 2 == 0) {
          // Los círculos blancos aumentan de izquierda a derecha
          diametro = tamañoCirculo * escala * (1 - i / float(columnas)) * factorReduccion;
        } else {
          // Los círculos negros disminuyen de izquierda a derecha
          diametro = tamañoCirculo * escala * (i / float(columnas)) * factorReduccion;
        }
      } else if (j == filas - 1) {
        // Si es la última fila (abajo)
        if ((i + j) % 2 == 0) {
          // Los círculos blancos aumentan de izquierda a derecha
          diametro = tamañoCirculo * escala * (i / float(columnas)) * factorReduccion;
        } else {
          // Los círculos negros disminuyen de izquierda a derecha
          diametro = tamañoCirculo * escala * (1 - i / float(columnas)) * factorReduccion;
        }
      } else {
        // Para todos los demás casos
        float distanciaMinima = min(min(i, columnas - 1 - i), min(j, filas - 1 - j));
        diametro = tamañoCirculo * escala * (1 - distanciaMinima / float(columnas)) * factorReduccion;
      }
      
      // Guardo el diámetro original del círculo en el arreglo
      diametrosOriginales[i * filas + j] = diametro;
      // Establezco el diámetro actual igual al original
      diametrosActuales[i * filas + j] = diametro;
    }
  }
}

void draw() {
  background(112, 117, 120); // Limpio la pantalla
  
  // Dibujo la imagen en la parte izquierda
  image(img, 0, 0, height, height);  // Ajusta la imagen al tamaño del cuadrado izquierdo
  
  // Dibujo los círculos considerando el movimiento del mouse
  float tamañoCirculo = height / filas; // Tamaño de los círculos
  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      float x = width / 2 + i * tamañoCirculo + tamañoCirculo / 2;
      float y = j * tamañoCirculo + tamañoCirculo / 2;
      
      // Determino el color según la posición
      if ((i + j) % 2 == 0) {
        fill(210, 214, 213);  // Color de los círculos blancos
      } else {
        fill(24, 26, 25);    // Color de los círculos negros
      }
      
      noStroke(); // Elimino el borde
      
      // Dibujo el círculo
      ellipse(x, y, diametrosActuales[i * filas + j], diametrosActuales[i * filas + j]);
    }
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    // Restauro los diámetros actuales a los originales
    for (int i = 0; i < columnas; i++) {
      for (int j = 0; j < filas; j++) {
        diametrosActuales[i * filas + j] = diametrosOriginales[i * filas + j];
      }
    }
  }
}

void mouseMoved() {
  // Muevo los círculos con respecto al cursor del mouse
  float tamañoCirculo = height / filas; // Tamaño de los círculos
  float escalaMaxima = 1.5; // Ampliación máxima respecto al tamaño original
  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      float x = width / 2 + i * tamañoCirculo + tamañoCirculo / 2;
      float y = j * tamañoCirculo + tamañoCirculo / 2;
      
      // Calculo la distancia desde el centro del círculo hasta el cursor
      float distancia = dist(x, y, mouseX, mouseY);
      // Determino la distancia máxima para escalar
      float distanciaMaxima = sqrt(sq(width / 2) + sq(height)) / 2;
      // Calculo la escala basada en la distancia al cursor
      float factorEscala = map(distancia, 0, distanciaMaxima, 1, escalaMaxima);
      
      // Aplico la escala
      diametrosActuales[i * filas + j] = diametrosOriginales[i * filas + j] * factorEscala;
    }
  }
}
