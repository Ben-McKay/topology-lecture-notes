settings.outformat="pdf";
settings.prc=false;
settings.render=16;

import solids; 
import graph;
import graph3;
import three;


import crop3D;

size(12cm);


material opaq=material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black);



currentprojection=perspective(5,4,4);

real R=3;
real a=1;

triple f(pair t) {
  triple z;
  z= ((R+a*cos(t.y))*cos(t.x),(R+a*cos(t.y))*sin(t.x),a*sin(t.y));
  return z;
}
surface s=surface(f,(0,0),(2pi,2pi),Spline);

// bool chop_condition(triple pt) { return pt.x > -R; }
// ss = crop(ss, chop_condition);

// s = crop(s, chop_condition);
surface ss=shift((2*R+2*a,0,0))*s;


draw(s,opaq,render(compression=Low,merge=true));
draw(ss,opaq,render(compression=Low,merge=true));

triple f11 (pair z)
{
  real y,ty,x,yy;
  triple zz;
  if ((z.y>=0) & (z.y<=1))
    {
      x=z.x+1/2*(z.x+R)^2/a;
      y=sin(pi*(z.y)/2)*sqrt((R+a)^2-x*x);
      zz=(-z.x,y,sqrt(a^2-(R-sqrt((x)^2+y^2))^2));
    }
  if ((z.y<0) & (z.y>=-1))
    {
      x=z.x+1/2*(z.x+R)^2/a;
      y=-sin(pi*abs(z.y)/2)*sqrt((R+a)^2-x*x);
      zz=(-z.x,y,sqrt(a^2-(R-sqrt((x)^2+y^2))^2));
    }
  if ((z.y>1) && (z.y<=2))
    {
      x=z.x+1/2*(z.x+R)^2/a;
      yy=2-z.y;
      y=sin(pi*(yy)/2)*sqrt((R+a)^2-x*x);
      zz=(-z.x,y,-sqrt(a^2-(R-sqrt((x)^2+y^2))^2));
    }
  if ((z.y>1) && (z.y<=2))
    {
      zz=(-z.x,y,-sqrt(a^2-(R-sqrt((x)^2+y^2))^2));
    }
  if ((z.y>=-2) && (z.y<-1))
    {
      x=z.x+1/2*(z.x+R)^2/a;
      yy=-2-z.y;
      y=-sin(pi*(abs(yy))/2)*sqrt((R+a)^2-x*x);
      zz=(-z.x,y,-sqrt(a^2-(R-sqrt((x)^2+y^2))^2));
    }
  return zz;
}

triple f21(pair z)
{
  triple z=f11(z);
  return (-z.x,z.y,z.z);
}
int N=20;
surface st=surface(f11,(-R-a,-2),(-R,2),N,2*N,Spline);
surface sstb=shift((2*R+2*a,0,0))*surface(f21,(-R-a,-2),(-R,2),N,2*N,Spline);
surface pont1=surface(st,sstb);

// pont1 = crop(pont1, chop_condition);

draw(pont1,opaq, render(compression=Low,merge=true));


shipout(scale(4.0)*currentpicture.fit());


