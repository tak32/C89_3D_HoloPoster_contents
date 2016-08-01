import ddf.minim.*;  //minimライブラリのインポート

float a;
float va;
float R_a;

float red, green, blue;
float vred, vgreen, vblue;
float R_red, R_green, R_blue;

float red2, green2, blue2;
float vred2, vgreen2, vblue2;
float R_red2, R_green2, R_blue2;

float sX, sY ,sZ;
 
 
Minim minim;  //Minim型変数であるminimの宣言
AudioInput in;    //サウンドデータ格納用の変数
PImage bgimg;

void setup(){
  size(2560, 1430, OPENGL);
  bgimg = loadImage("page1_hyoshi_holo_16_9_B2.png");
  minim = new Minim(this);
  //ステレオでオーディオ入力、バッファーサイズは512サンプル
  in = minim.getLineIn(Minim.STEREO, 512);
  noFill();
  strokeWeight(2);  //ファイルを再生
}

float randcolor(){
  R_a += random(-1, +1) * 0.6;
  R_a *= 0.99;
  va += R_a;
  a = 255+va;
  
  return a;
}

void draw() {
  R_red += random(-1, +1) * 0.6;
  R_green += random(-1, +1) * 0.5;
  R_blue += random(-1, +1) * 0.6;
  R_red *= 0.99;
  R_green *= 0.99;
  R_blue *= 0.99;
  
  vred += R_red;
  vgreen += R_green;
  vblue += R_blue;
  
  red = 255+vred;
  green = 255+vgreen;
  blue = 255+vblue;
  
  R_red2 += random(-1, +1) * 0.6;
  R_green2 += random(-1, +1) * 0.5;
  R_blue2 += random(-1, +1) * 0.6;
  R_red2 *= 0.99;
  R_green2 *= 0.99;
  R_blue2 *= 0.99;
  
  vred2 += R_red;
  vgreen2 += R_green;
  vblue2 += R_blue;
  
  red2 = 255+vred;
  green2 = 255+vgreen;
  blue2 = 255+vblue;
  
  stroke(red, green, blue);
  fill(red2, green2, blue);
  
  
  background(0);
  
  hint(DISABLE_DEPTH_TEST); 
  image( bgimg, 0, 0 );   
  hint(ENABLE_DEPTH_TEST); 
  
  lights();
  strokeWeight(5);
  ambientLight(102, 102, 102);
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, 0, 0, -1);
  specular(255, 255, 255);
  
  pushMatrix();
  translate( 2100, 665, -30);  
  rotateZ(radians(frameCount*2-10));
  rotateY(radians(-frameCount*2-10));
  for(int i = 0; i < in.bufferSize()/2 -1; i++){
    float y = map(in.right.get(i), -1, 1, 0, height/2);
    box(y/2);
  }
  popMatrix();
}

void stop() {
  minim.stop();
  super.stop();
}