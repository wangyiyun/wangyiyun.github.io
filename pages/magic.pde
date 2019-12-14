//感谢 Reskip 的帮助
int r,g,b;
var base = new int[50][50];
int wireNum;
int maxR = 400;
int blank,bw = 50;
int RunesNum;
float RunesSize;
int rectNum;
float rectSize;
int starNum;
float starSize;
float lineLenth;
float lineSize;
PImage img;

void SetRunes()
{
  int num,pnum = -1;
  String temp;
  Runes = new Array();
  RunesNum = int(random(10,30));
  for(int i = 0 ; i < RunesNum ; i++)
  {
    num = int(random(1,24));
    while(i > 0 && num == pnum) num = int(random(1,24));
    pnum =num;
    if(num < 10) temp = "http://www.aliceyiyun.com/pages/data/r_"+"0"+num+".png";
    else temp = "http://www.aliceyiyun.com/pages/data/r_"+num+".png";
    PImage tmpImg = loadImage(temp);
    Runes.push(tmpImg);
  }
}

int setColor()
{
   return int(random(150,255));
}

void setWire()
{
  wireNum = int(random(8,14));
  for(int i = 0 ; i < int(wireNum/2) ; i++)
  {
    maxR = int(random(maxR-60,maxR));
    base[i][0] = maxR;
    base[i][1] = int(random(1,6));
    while(i > 0 && base[i][1] == base[i-1][1])
    {
      base[i][1] = int(random(1,6));
    }
  }
  blank = maxR;
  maxR -= bw;
  for(int i = int(wireNum/2) ; i < wireNum ; i++)
  {
    maxR = int(random(maxR-30,maxR));
    base[i][0] = maxR;
    base[i][1] = int(random(1,6));
    while(i > 0 && base[i][1] == base[i-1][1])
    {
      base[i][1] = int(random(1,6));
    }
  }
}

void keyPressed()
{
  if(key == ' ') setup();
}

void setup()
{
  maxR = 400;
  size(500,500);
  background(0);
  r = setColor();
  g = setColor();
  b = setColor();
  setWire();
  RunesSize = random(0.6,0.8)*blank*0.0025-RunesNum*0.0015;
  SetRunes();
  rectNum = int(random(1,3))*2+1;
  rectSize = random(37,40)*rectNum;
  starNum = int(random(5,7));
  starSize = random(12,27)*starNum;
  lineLenth = random(30,50);
  lineSize = random(500,600)-RunesSize*350;
}

void wire(int size,int strW, int r, int g, int b)
{
  noFill();
  strokeWeight(strW);
  stroke(r,g,b,150);
  ellipse(width/2, height/2,size,size);
}

void funRunes()
{
  float a = TWO_PI/RunesNum;
  float rx,ry;
  float t = blank/2-10*RunesSize;
  for(int i = 0 ; i < RunesNum ; i++)
  {
    rx = t*cos(a*i);
    ry = t*sin(a*i);
    imageMode(CENTER);
    translate(rx,ry);
    tint(r,g,b);

    pushMatrix();
    rotate(3*PI/2);
    rotate(a*i);
    scale(RunesSize);
    image(Runes[i],0,0);
    popMatrix();

    translate(-rx,-ry);
  }
}

void rectStar()
{
  strokeWeight(2);
  stroke(r,g,b,200);
  float a = TWO_PI / rectNum;
  rectMode(CENTER);
  for (float i = 0; i < TWO_PI; i += a)
  {
    rotate(a);
    rect(0,0,rectSize,rectSize);
  }
}

void lines()
{
  strokeWeight(1.8);
  stroke(r,g,b,150);
  float a = TWO_PI / (25-rectNum*2);
  for (float i = 0; i < TWO_PI; i += a)
  {
    rotate(a);
    line(0,lineSize/2-100,0,lineSize/2-80+lineLenth);
    fill(r,g,b,500);
    triangle(0,lineSize/2-100-40*(1-RunesSize/2),-5*(1-RunesSize/2),lineSize/2-80,5*(1-RunesSize/2),lineSize/2-80);
  }
}

void star(float strW, float radius1, float radius2, int points)
{
  noFill();
  strokeWeight(strW);
  stroke(r,g,b,300);
  float angle = TWO_PI / points;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle)
  {
    float sx = cos(a) * radius2;
    float sy = sin(a) * radius2;
    vertex(sx, sy);
    sx = cos(a+halfAngle) * radius1;
    sy = sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void draw()
{
  background(0);
  for(int i = 0 ; i < wireNum ; i++) wire(base[i][0],base[i][1],r,g,b);

  pushMatrix();
  translate(width/2, height/2);
  rotate(frameCount / 100.0);
  star(3, starSize, starSize/2, starNum);
  star(2, starSize/1.2, starSize/2.4, starNum);
  rotate(PI/starNum);
  star(2, starSize/1.5, starSize/3, starNum);
  popMatrix();

  pushMatrix();
  translate(width/2, height/2);
  rotate(frameCount / 50.0);
  rectStar();
  popMatrix();
  pushMatrix();
  translate(width/2, height/2);
  rotate(frameCount / -100.0);
  funRunes();
  popMatrix();
  pushMatrix();
  translate(width/2, height/2);
  rotate(frameCount / -50.0);
  lines();
  popMatrix();
}