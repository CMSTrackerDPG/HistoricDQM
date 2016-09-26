from basic import BaseMetric

class Landau(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal, paramDefaults):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        self.parameters = paramDefaults
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        
    def calculate(self, histo):
        from ROOT import TF1
        fit = TF1("landau","[2]*TMath::Landau(x,[0],[1],0)", *(self.range))
        fit.SetParameters(*(self.parameters))
        #3x to stabilise minimization
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        del fit
        return result

class LandauAroundMaxBin(BaseMetric):
    def __init__(self, diseredParameter, width):
        BaseMetric.__init__(self)
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        self.theWidth = width
        
    def calculate(self, histo):
        from ROOT import TF1
        maxbincenter = histo.GetBinCenter( histo.GetMaximumBin() )
        self.range = [maxbincenter - self.theWidth , maxbincenter + self.theWidth]
        #3x to stabilise minimization
        histo.Fit("landau","OR","",*(self.range))
        histo.Fit("landau","OR","",*(self.range))
        histo.Fit("landau","OR","",*(self.range))
        func = histo.GetFunction("landau")
        result = (func.GetParameter(self.desired), func.GetParError(self.desired))
        return result

class Gaussian(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal, paramDefaults):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        self.parameters = paramDefaults
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        
    def calculate(self, histo):
        from ROOT import TF1
        fit = TF1("gaus","[2]*TMath::Gaus(x,[0],[1],0)", *(self.range))
        fit.SetParameters(*(self.parameters))
        histo.Fit(fit,"QOR")
        result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        del fit
        return result

class FlatLine(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal, paramDefault):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        self.parameter = paramDefault
        assert diseredParameter in [0], "can only get parameter 0,,not '%s'"%desiredParameter
        self.desired = diseredParameter
        
    def calculate(self, histo):
        from ROOT import TF1
        fit = TF1("pol0","[0]", *(self.range))
        fit.SetParameter(0,self.parameter)
        histo.Fit(fit,"QOR")
        result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        del fit
        return result

class FlatLineXcut(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal, paramDefault):
        BaseMetric.__init__(self)
        
        self.range = [minVal, maxVal]
        self.parameter = paramDefault
        assert diseredParameter in [0], "can only get parameter 0,,not '%s'"%desiredParameter
        self.desired = diseredParameter
        
    def calculate(self, histo):
        from ROOT import TF1
        Nbins = histo.GetNbinsX()
        NN=0
        for xbin in range(Nbins):
            if histo.GetBinContent(xbin)>0:
                NN=xbin
        self.range = [1, histo.GetXaxis().GetBinCenter( NN-3 ) ]
        fit = TF1("pol0","[0]", *(self.range))
        fit.SetParameter(0,self.parameter)
        histo.Fit(fit,"QOR")
        result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        del fit
        return result


