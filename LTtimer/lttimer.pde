
int WIDTH;
int HEIGHT;
int fontsize = 50;

int minutes;
int seconds;
int milseconds;

int wholetime;
boolean isStarted=false;

int startmin;
int startsec;
int startmil;
int nowmin;
int nowsec;
int nowmil;
String stmin;
String stsec;
String stmil;

int lx = 20;
int ly = 50;

int yoi;

float f;
ArrayList<Yoine> yoine;

PFont fontA;

void setup(){
  WIDTH = 400;
  HEIGHT = 300;
  size(WIDTH,HEIGHT);
  fill(255);
  yoine = new ArrayList();
  fontA = loadFont("Gisha-48.vlw");
  textAlign(CENTER);
  reset();
}

void draw(){
    background(0);
    if (keyPressed) {
      if (key == 'b' || key == 'B') {
        startup();  //StopWatch Start
      }
      if (key == 'n' || key == 'N') {
        reset();    //Reset Timer
      }
      if (key == 'm' || key == 'M') {
        yoine.add(new Yoine((int)random(width),(int)random(height),300)); //Yoine!
      }
    }
   if (mousePressed) {
      if (mouseX<width/2&&isStarted==false&&yoi==0) {
        yoi = 10;
        startup();
        rect(0,0,width/2,height);
        fill(0,153,153,20);
      }
      if (mouseX<width/2&&isStarted==true&&yoi==0) {
        yoi = 10;
      }
      if (mouseX>width/2) {
        reset();
      }
  }
  
  int nowtime = (minutes*60 + seconds)*1000 + milseconds;
  if(isStarted == true){
    gettime();
    wholetime = (minutes*60 + seconds)*1000 + milseconds;
    nowtime += startmil-nowmil;
    f = ( (float)(nowtime) / (float)((minutes*60 + seconds)*1000 + milseconds) )*2*PI;
    circlegraph(f,wholetime,nowtime);  
    
    if(nowtime>0){
      if(nowtime > 60*1000){
        int min = nowtime / (60*1000);
        int sec = (nowtime - min*(60*1000))/1000;
        int mil = (nowtime - min*(60*1000) -sec*1000)/10;
        stmin = nf(0,2);
        stsec = nf(min,2);
        stmil = nf(sec,2);
      }else{
        int min = nowtime / (60*1000);
        int sec = (nowtime - min*(60*1000))/1000;
        int mil = (nowtime - min*(60*1000) -sec*1000)/10;
        stmin = nf(min,2);
        stsec = nf(sec,2);
        stmil = nf(mil,2);
      }
    }else{
      stmin = nf(0,2);
      stsec = nf(0,2);
      stmil = nf(0,2);
      isStarted = false;
    }
    //println(nowtime);
    //println(f);
  }else{
    circlegraph(f,wholetime,0);
  }
    if(nowtime > 60*1000){
        int min = nowtime / (60*1000);
        int sec = (nowtime - min*(60*1000))/1000;
        stmin = nf(0,2);
        stsec = nf(min,2);
        stmil = nf(sec,2);
      }
    
    //fill(255);
    colfill(f);
    textFont(fontA,fontsize);
    text(stmin+":"+stsec+":"+stmil, width/2,ly);  
    
    fill(150);
    textFont(fontA,fontsize*0.5);
    text("Total Yoine! : "+yoine.size(), width/2,ly+fontsize/2);  
    
     for(int i=0;i<yoine.size();i++){
      Yoine y = (Yoine) yoine.get(i);
      y.paint();
      //if(y.isFaded()==true) yoine.remove(i);
    }
    println(yoine.size());
    yoi--;
    if(yoi<0)  yoi = 0;
    println(yoi);
    
}

void startup(){
  if(isStarted == false){
    startmin = minute();
    startsec = second();
    startmil = millis();
    println(startmin+","+startsec+","+startmil);
  }
  isStarted = true;
}

void gettime(){
  nowmin = minute();
  nowsec = second();
  nowmil = millis();
}

void reset(){
  minutes = 5;
  seconds = 0;
  milseconds = 0;
  f = 2*PI-0.00001f;
  isStarted = false;
  stmin = nf(minutes,2);
  stsec = nf(seconds,2);
  stmil = nf(milseconds,2);
  yoine.clear();
}

void colfill(float f){
  if(f>PI+HALF_PI){    
    fill(102,102,255);
  }else if(f>PI+QUARTER_PI){
    fill(102,153,255);
  }else if(f>PI){
    fill(102,255,153);
  }else if(f>3*QUARTER_PI){
    fill(102,255,102);
  }else if(f>HALF_PI){
    fill(255,255,102);
  }else if(f>QUARTER_PI){
    fill(255,204,51);
  }else if(f>0){
    fill(255,51,51);
  }else{
    fill(100);
  }
}


void textbutton(String str,int i){
  int dw = 30;
  int dh = 24;
    fill(100);
    rect(dw*1,dh*i,dw*str.length(),dh);
    fill(255);
    
    PFont font;
    font = loadFont("Gisha-24.vlw"); 
    textFont(font); 
    text(str,dw*1,dh*i,dw*str.length(),dh);
}

void circlegraph(float f,int i,int j){
  int cx = width/2;
  int cy = (height/5)*3;
  int size = (height/5)*3;
  double area = 160;
  double dia = 1.1;
  ellipseMode(CENTER);  
  fill(100);  
    /*if( (PI+HALF_PI+area>f&&f>PI+HALF_PI)
      || (PI+QUARTER_PI+area>f&&f>PI+QUARTER_PI) 
      || (PI+area>f&&f>PI)
      || (3*QUARTER_PI+area>f&&f>3*QUARTER_PI) 
      || (HALF_PI+area>f&&f>HALF_PI) 
      || (QUARTER_PI+area>f&&f>QUARTER_PI)
      || (QUARTER_PI/2+area>f&&f>QUARTER_PI/2)  ){    
    size = (int)( (double)size*dia );
  }
  */
    
  if( ( (int)((double)i*0.75+area)>j&&j>(int)((double)i*0.75) )
      || ( (int)((double)i*0.625+area)>j&&j>(int)((double)i*0.625) ) 
      || ( (int)((double)i*0.5+area)>j&&j>(int)((double)i*0.5) )
      || ( (int)((double)i*0.375+area)>j&&j>(int)((double)i*0.375) ) 
      || ( (int)((double)i*0.25+area)>j&&j>(int)((double)i*0.25) ) 
      || ( (int)((double)i*0.125+area)>j&&j>(int)((double)i*0.125) )
      || ( (int)((double)3000+area)>j&&j>3000 )
      || ( (int)((double)2000+area)>j&&j>2000 )
      || ( (int)((double)1000+area)>j&&j>1000 )  
    ){    
      size = (int)( (double)size*dia );
  }
  
  ellipse(cx, cy, size, size);
  colfill(f);
  arc(cx, cy, size, size, PI+HALF_PI, PI+HALF_PI+f, PIE);
}



/*
 *Yoine!!
 */
public class Yoine {
    int x;
    int y;
    float al;
    
    public Yoine(int x,int y,float al){
      this.x = x;
      this.y = y;
      this.al = al;
    }
    public void paint(){
      fill(256,256,256,al);
      textFont(fontA,20);
      text("Yoine!",x,y);
      fade();
      move();
      }  
    public void fade(){
        al = al-2.0f;
        if(al<0.0f)  al = 0.0f;
    }
    public void move(){
        if(al>0.0f) x -= 1;
    }
    public boolean isFaded(){
      if(al<0.0f){
        return true;
      }else{
        return false;
      }
    }

}
