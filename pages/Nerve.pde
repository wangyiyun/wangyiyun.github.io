ArrayList<Particle> position = new ArrayList();
int maxR = 50;
int minR = 20;
float maxLink = 40;
int maxNum = 100;
float burstChance = 0.01;
void setup() 
{
  size(500, 500);
  background(0);
  for(int i = 30 ; i < height ; i+=30)
  {
    for(int j = 0 ; j < 360 ; j+=10)
    {
      Particle P = 
      new Particle(width/2+i*cos(j*PI/180), height/2+i*sin(j*PI/180), 10,i);
      position.add(P);
    }
  }
}

void draw() {
  frameRate(12);
  background(0);
  for(int i = 0 ; i < position.size(); i++)
  {
    Particle P = position.get(i);
    P.burst();
    P.show();
    P.move();
    P.link();
  }
}

float setColor()
{
   return random(0,255); 
}

class Particle {
  float x, y, x_center, y_center, angle, delta, r;
  float color_r,color_g,color_b,color_a;
  boolean ifBurst = false;
  Particle(float x_center, float y_center, float r,int alpha) {
    this.x_center = x_center;
    this.y_center = y_center;
    this.r = r;
    
    color_r = setColor();
    color_g = setColor();
    color_b = setColor();
    color_a = 255-0.9*alpha;
    
    delta = random(-15,15);
  }
  void burst()
  {
    float burstTry = random(0,1);
    if(burstTry <= burstChance)
    {
      ifBurst = true;
    }
  }
  
  void show() {
    x = x_center + r*cos(angle*PI/180);
    y = y_center + r*sin(angle*PI/180);
    if(ifBurst)
    {
      noStroke();
      fill(#FCFFB7,color_a);
      ellipse(x, y, 6, 6);
    }
    else
    {
      noStroke();
      fill(color_r,color_g,color_b,color_a);
      float r_temp = random(3,5);
      ellipse(x, y, r_temp, r_temp);
    }
  }
  
  void move() {
    angle+=delta;
  }
  
  void link() {
    for (int i = 0 ; i < position.size() ; i++)
    {
      Particle P = position.get(i);
      if(P != this)
      {
        if (dist(x, y, P.x, P.y) < maxLink)
        {
          float line_r,line_g,line_b,line_a;
          line_r = (color_r + P.color_r)/2;
          line_g = (color_g + P.color_g)/2;
          line_b = (color_b + P.color_b)/2;
          line_a = (color_a + P.color_a)/2;
          if(ifBurst)
          {
            stroke(#FCFFB7,line_a);
            strokeWeight(1.5);
            line(x, y, P.x, P.y);
          }
          else
          {
            stroke(line_r,line_g,line_b,line_a);
            strokeWeight(1);
            line(x, y, P.x, P.y);
          }
        }
      }
    }
    ifBurst = false;
  }
}
