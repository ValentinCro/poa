package fiche6.controller;

import java.awt.Color;

import fiche6.domain.RainbowModel;
import fiche6.util.AbstractObserver;
import fiche6.util.Observer;
import fiche6.util.Subject;
import fiche6.util.SwingWrappers.WJTextField;

public aspect TextColorObserver extends AbstractObserver<RainbowModel, WJTextField>{

	public pointcut subjectChange(RainbowModel s) : target(s) && call(void fiche6.domain.StdRainbowModel.changeColor(..)); 
	
	@Override
	protected void updateObserver(RainbowModel s, WJTextField o) {
		// TODO Auto-generated method stub
		Color c = s.getColor();
		o.setText("[" + c.getRed() + "," + c.getGreen()
        + "," + c.getBlue() + "]");
	}

}
