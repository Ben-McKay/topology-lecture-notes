// intersection of two paraboloids
settings.outformat="pdf";
settings.prc=false;
settings.render=8;

import graph3;
import solids;
size(0,150);
currentprojection=perspective(-.5,2,1.5);

pen color=white+opacity(.5);
real alpha=360;

real f(real x) {
	real res;
	if (x >= .99)
	{
		res=0;
	} else
	{
		if (x<= 0.01)
		{
			res=1;
		}
		else
		{
			res=sqrt(1-x^2);
		}
	}
	return res;
}


pair F(real x) {return (x,f(x));}

path p=graph(F,0,1,n=10,operator ..);// --cycle;
path3 p3=path3(p);

revolution a=revolution(p3,Y,-alpha,0);
render render=render(compression=0,merge=true);
draw(rotate(90,X)*surface(a),color,render);

