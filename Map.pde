  Node head;
  Node temp;
  static int stop=10000;
  static int count=0;
  static float rate=1;
  static int nRate=6;
  void setup(){
     head=new Node();
     temp=head;
    for(int i=0;i<20;i++){
      temp.next=new Node();
      temp.next.prev=temp;
      temp=temp.next;
    }
     size(1000, 1000);
    background(255);
    noStroke();
    stroke(155);
    ellipse(500,500,1000,1000);
  
  }
  void draw(){
    if(count%2000==0){
      nRate--;
    }
    count++;
    background(255);
    stroke(155);
    ellipse(500,500,1000,1000);
    rate=rate*0.999;
    head.update(nRate);
    temp=head;
    while(temp.next!=null){
      stroke(0);
      line(temp.x,temp.y,temp.next.x,temp.next.y);
      temp=temp.next;
    }
    delay(10);
    if(count==stop)
      noLoop();
  }
  
  class Node{
    float x;
    float y;
    Node next;
    Node prev;
    Node(){
      setXY();
    }
    void addPrev(Node prev){
      this.prev=prev;
    }
    void addNext(Node next){
      this.next=next;
    }
    float distance(float x1,float y1){
      return dist(x1,y1,this.x,this.y);
    }
    void update(int neighbor_rate){
      Node num =new Node();
     //print(num.x+" "+" "+num.y+" dist "+dist(num.x,num.y,500,500)+"\n");
      
      
      Node close=this.closest(num.x,num.y);
      close.x=close.x+rate*(num.y-close.x);
      close.y=close.y+rate*(num.x-close.y);
      //go forward
      float i=1;
      while(close.next!=null&&i<=neighbor_rate){
           close.next.x=close.next.x+(rate/(i+1))*(num.x-close.next.x);
           close.next.y=close.next.y+(rate/(i+1))*(num.y-close.next.y);
           close=close.next;
           i++;
      }
      //go backwards
       i=1;
      while(close.prev!=null&&i<=neighbor_rate){
           close.prev.x=close.prev.x+(rate/(i+1))*(num.x-close.prev.x);
           close.prev.y=close.prev.y+(rate/(i+1))*(num.y-close.prev.y);
           close=close.prev;
           i++;
      }
    }
    Node closest(float x1,float y1){
      Node temp=this;
      float d=1000;
      Node close=this;
      while(temp.next!=null){
        if(temp.distance(x1,y1)<d){
          d=temp.distance(x1,y1);
          close=temp;
      }
      temp=temp.next;
    }
    return close;
  }
  void setXY(){
   float a = random(0,1) * 2 * PI;
  float r = 500 * sqrt(random(0,1));
  float x = r * cos(a);
  float y = r * sin(a);
  this.x=x+500;
  this.y=y+500;
  }
  }
  
 
