settings.outformat = "pdf";
settings.render = 16;
size(8cm);


/***************************************************************************
I want to imitate the Mathematica code:
With[{R = 1.2, r = 1/2, a = Sqrt[2]}, 
 ContourPlot3D[-a^2 + ((-r^2 + R^2)^2 - 
       2 (r^2 + R^2) ((-r - R + x)^2 + y^2) + 
       2 (-r^2 + R^2) z^2 + ((-r - R + x)^2 + y^2 + z^2)^2) ((-r^2 + 
         R^2)^2 - 2 (r^2 + R^2) ((r + R + x)^2 + y^2) + 
       2 (-r^2 + R^2) z^2 + ((r + R + x)^2 + y^2 + z^2)^2) == 
   0, {x, -2 (r + R), 2 (r + R)}, {y, -(r + R), (r + R)}, {z, -r - a, 
   r + a}, BoxRatios -> Automatic, PlotPoints -> 35, 
  MeshStyle -> Opacity[.2], 
  ContourStyle -> 
   Directive[Orange, Opacity[0.8], Specularity[White, 30]], 
  Boxed -> False, Axes -> False]]
***************************************************************************/

real R=1.2;
real r=.5;
real a=sqrt(2);
real Rsqr=R^2;
real rsqr=r^2;
real asqr=a^2;
real diffsqr=Rsqr-rsqr;
real sqrdiffsqr=diffsqr^2;
real twsumsqr=2*(rsqr+Rsqr);
real twdiffsqr=2*diffsqr;

import contour3;
currentprojection=perspective(4,6,8);
real f(real x, real y, real z) 
{ 
	real ysqr=y^2;
	real zsqr=z^2;
	real p=(-r - R + x)^2;
	real q=(r + R + x)^2;
	return
		-asqr 
		+ 
		(
			sqrdiffsqr 
			- twsumsqr*(p + ysqr) 
			+ twdiffsqr*zsqr
			+ (p+ysqr+zsqr)^2
		)
		*
		(
			sqrdiffsqr 
			- twsumsqr*(q + ysqr) 
			+ twdiffsqr*zsqr
			+ (q+ysqr+zsqr)^2
		);
}

material opaq=material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black);

draw(
	surface(
		contour3(
			f, 
			(-2*(r + R), -(r + R),-r - a),
			(2*(r + R), (r + R), r + a), 
			nx=80)
	), 
	surfacepen=opaq
);

shipout(scale(4.0)*currentpicture.fit());





