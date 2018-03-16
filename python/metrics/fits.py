from basic import BaseMetric

class LanGau(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal, controlVal, paramDefaults):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        self.parameters = paramDefaults
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        self.controlVal = controlVal 
        
    def calculate(self, histo):
        import ROOT
        ROOT.gSystem.Load("/afs/cern.ch/user/c/cctrack/scratch0/hDQM/CMSSW_8_0_2/src/DQM/SiStripHistoricInfoClient/test/NewHDQM/metrics/langau_c")
        from ROOT import langaufun
        from ROOT import TF1
        fit = TF1("langau",langaufun, self.range[0],self.range[1],4)
        if(histo.GetEntries()<150):
            histo.Rebin(2)
        fit.SetParameters(*(self.parameters))
        if(histo.GetBinCenter(histo.GetMaximumBin())>self.range[0]):
            fit.SetParameter(1,histo.GetBinCenter(histo.GetMaximumBin()))
        fit.SetParameter(2,histo.Integral())
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        control = 0
        while control < 5 :
            if(fit.GetParameter(0)<self.controlVal or fit.GetParameter(1)<self.range[0]):
                print "########### REFIT #######"
                fit.SetParameters(*(self.parameters))
                if(histo.GetBinCenter(histo.GetMaximumBin())>self.range[0]):
                    fit.SetParameter(1,histo.GetBinCenter(histo.GetMaximumBin()))
                fit.SetParameter(2,histo.Integral()*(5+control)/5)
                fit.SetParameter(4,self.parameters[3]*(control+1))
                histo.Fit(fit,"QO","",self.range[0]-2,self.range[1])
                histo.Fit(fit,"QO","",self.range[0]-2,self.range[1])
                histo.Fit(fit,"QO","",self.range[0]-2,self.range[1])
                control=control+1
            else:
                print "##### GOOD #####"
                control = 5
        result = (fit.GetMaximumX(), fit.GetParError(self.desired))
        del fit
        return result

class GauLand(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal, paramDefaults):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        self.parameters = paramDefaults
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        
    def calculate(self, histo):
        from ROOT import TF1
        fit = TF1("landau","[2]*TMath::Landau(x,[0],[1],0)+[4]*TMath::Gaus(x,[0],[3])", *(self.range))
        fit.SetParameters(*(self.parameters))
        fit.SetParameter(2,histo.GetMaximum()/2)
        fit.SetParameter(4,histo.GetMaximum()/2)
        #3x to stabilise minimization
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        del fit
        return result

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
        histo.Fit(fit,"OR")
        if (fit.GetParameter(self.desired)>0) :
            result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        else :
            result = (0.0, 0.0)
        del fit
        return result

class LandauTest(BaseMetric):
    def __init__(self, diseredParameter, minVal1, maxVal1, minVal2, maxVal2, turnRun, paramDefaults):
        BaseMetric.__init__(self)
        self.range2 = [minVal2, maxVal2]
        self.range1 = [minVal1, maxVal1]
        self.turn = turnRun
        self.parameters = paramDefaults
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        
    def calculate(self, histo):
        from ROOT import TF1
        if self._run >= self.turn :
            print "Range 2"
            fit = TF1("landau","[2]*TMath::Landau(x,[0],[1],0)", *(self.range2))
            fit.SetParameters(*(self.parameters))
        else :
            print "Range 1"
            fit = TF1("landau","[2]*TMath::Landau(x,[0],[1],0)", *(self.range1))
            fit.SetParameters(*(self.parameters))
            fit.SetParameter(0,fit.GetParameter(0)*1.58)
            fit.SetParameter(1,fit.GetParameter(1)*1.58)
        #3x to stabilise minimization
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"OR")
        if (fit.GetParameter(self.desired)>0 and fit.GetParameter(self.desired)<60000) :
            result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        else :
            result = (0.0, 0.0)
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
        histo.Fit("landau","QOR","",*(self.range))
        histo.Fit("landau","QOR","",*(self.range))
        histo.Fit("landau","OR","",*(self.range))
        func = histo.GetFunction("landau")
        result = (func.GetParameter(self.desired), func.GetParError(self.desired))
        return result

class LandauAroundMax(BaseMetric):
    def __init__(self, diseredParameter, lowFrac, highFrac, hLimit):
        BaseMetric.__init__(self)
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        self.lowF = lowFrac
        self.highF = highFrac
        self.cut = hLimit
        
    def calculate(self, histo):
        from ROOT import TF1
        maxbin=histo.GetMaximumBin()
        if histo.GetBinContent(maxbin-1) > histo.GetBinContent(maxbin+1) :
            maxbin2=maxbin-1
        else :
            maxbin2=maxbin+1
        maxbincenter = (histo.GetBinCenter( maxbin ) + histo.GetBinCenter( maxbin2 ))/2
        self.range = [maxbincenter*self.lowF , maxbincenter*self.highF]
        #print maxbincenter
        fit = TF1("landau","[2]*TMath::Landau(x,[0],[1],0)", *(self.range))
        fit.SetParameter(0,maxbincenter)
        fit.SetParameter(1,maxbincenter/10.)
        fit.SetParameter(2,histo.GetMaximum())
        #3x to stabilise minimization
        histo.Fit(fit,"QOR","",*(self.range))
        histo.Fit(fit,"QOR","",*(self.range))
        histo.Fit(fit,"OR","",*(self.range))
        if (fit.GetParameter(self.desired)>0 and fit.GetParameter(self.desired)<self.cut) :
            result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
        else :
            result = (0.0, 0.0)
        del fit
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


