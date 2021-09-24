settings.outformat="pdf";
settings.prc=false;
settings.render = 4;

// unitsize(1cm);
size(20cm);
import graph3; 
import solids;

triple pers=(5,4,3);

currentprojection=perspective(pers.x,pers.y,pers.z);

real R=3;
real a=1;

revolution torus=revolution(reverse(Circle(R*X,a,Y,32)),axis=Z,0,360);
surface s=surface(torus);

draw(s,
material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black),
render(merge=true));

int ni=30;
int nj=10;
for(int i=0; i < ni; ++i) {
	for(int j=0; j < nj; ++j) {
	  dot(
		(a*cos(2*pi*j/nj)+R)*cos(2*pi*i/ni)*X+
		(a*cos(2*pi*j/nj)+R)*sin(2*pi*i/ni)*Y+
		a*sin(2*pi*j/nj)*Z
		);
	}
}



shipout(scale(4.0)*currentpicture.fit());



