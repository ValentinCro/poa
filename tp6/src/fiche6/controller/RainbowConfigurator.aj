package fiche6.controller;

import fiche6.domain.RainbowModel;
import fiche6.domain.StdRainbowModel;
import fiche6.ihm.Rainbow;
import fiche6.util.SwingWrappers.WJFrame;
import fiche6.util.SwingWrappers.WJTextField;

public aspect RainbowConfigurator {

	declare parents : fiche6.domain.RainbowModel extends fiche6.util.Subject;
	declare parents : fiche6.util.SwingWrappers.WJFrame extends fiche6.util.Observer;
	declare parents : fiche6.util.SwingWrappers.WJTextField extends fiche6.util.Observer;

	pointcut constructorRainbowCalled(Rainbow r): this(r) && execution(fiche6.ihm.Rainbow.new(..));
	
	RainbowModel[] models;

	private void createModels() {
		models = new StdRainbowModel[2];
		for (int i = 0; i < models.length; i++) {
			models[i] = new StdRainbowModel();
		}
	}
	
	after(Rainbow r) : constructorRainbowCalled(r) {
		createModels();
		createControllers(r);
		
		ColorObserver.aspectOf().notifyObservers();
		TextColorObserver.aspectOf().notifyObservers();
	}
	
	private void createControllers(Rainbow r) {
		RainbowModel[] tabModel = {models[0], models[0], models[1]};
		for(int i = 0; i < tabModel.length; i++) {
			ColorObserver.aspectOf().addObserver(tabModel[i], (WJFrame) r.getFrame(i));
			TextColorObserver.aspectOf().addObserver(tabModel[i], (WJTextField) r.getColor(i));
		}
	}
}
