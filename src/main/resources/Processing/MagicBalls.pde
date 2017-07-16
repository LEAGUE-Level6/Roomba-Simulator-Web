
void setup(){
 size(1000, 1000);
 background(0);
 frameRate(sqrt(sq(height) + sq(width))/4);
}
 
void draw(){
    
    smooth();
    int y = (int)random(height);
    int x = (int)random(width);
    float r = random(255);
    float g = random(255);
    float b = random(255);
    float xy = random(sqrt(sq(height) + sq(width))/20) + 20;
    fill(r, g, b);
    ellipse(x, y, xy, xy);
    makeMagical();
    
}
void makeMagical() {
  fill( 0, 0, 0, 10 );
  rect(0, 0, width, height);
  noStroke();
}


