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
        ROOT.gSystem.Load("/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/metrics/langau_c")
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

class LanGauAroundMax(BaseMetric):
    def __init__(self, diseredParameter, minFrac, maxFrac, controlVal):
        BaseMetric.__init__(self)
        self.min = minFrac
        self.max = maxFrac
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        self.controlVal = controlVal 
        
    def calculate(self, histo):
        import ROOT
        ROOT.gSystem.Load("/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/metrics/langau_c")
        from ROOT import langaufun
        from ROOT import TF1
        if(histo.GetEntries()<150):
            histo.Rebin(2)
        initm=histo.GetBinCenter(histo.GetMaximumBin())
        fit = TF1("langau",langaufun, self.min*initm,self.max*initm,4)
        fit.SetParameter(0,histo.GetRMS()/6)
        fit.SetParameter(1,initm)
        fit.SetParameter(2,histo.Integral())
        fit.SetParameter(3,histo.GetRMS()/6)
        fit.SetParLimits(3,0,1000)
        histo.Fit(fit,"QORB")
        histo.Fit(fit,"QORB")
        histo.Fit(fit,"ORB")
        control = 0
        while control < 5 :
            if(fit.GetParameter(0)<self.controlVal or fit.GetParameter(1)<self.min*initm):
                print "########### REFIT #######"
                fit.SetParameter(0,histo.GetRMS()/6)
                fit.SetParameter(1,initm)
                fit.SetParameter(2,histo.Integral()*(5+control)/5)
                fit.SetParameter(3,histo.GetRMS()/6*(control+1))
                histo.Fit(fit,"QORB","")
                histo.Fit(fit,"QORB","")
                histo.Fit(fit,"ORB","")
                control=control+1
            else:
                print "##### GOOD #####"
                control = 5
        result = (fit.GetParameter(self.desired), fit.GetParError(self.desired))
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
    def __init__(self, diseredParameter, lowFrac, highFrac, hLimit, lowLimit=0):
        BaseMetric.__init__(self)
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        self.lowF = lowFrac
        self.highF = highFrac
        self.cut = hLimit
        self.lowLimit= lowLimit
        
    def calculate(self, histo):
        from ROOT import TF1
        if self.lowLimit != 0:
            histo.GetXaxis().SetRangeUser(self.lowLimit,histo.GetXaxis().GetXmax())
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

class StudentT(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter

    def calculate(self, histo):
        import ROOT
        import math
        ROOT.gSystem.Load("/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/metrics/residuals_c")
        from ROOT import tStud
        from ROOT import TF1
        fit = TF1("tStud",tStud,self.range[0],self.range[1],5)
        fit.SetParameters(0,histo.GetRMS()/5,2,histo.GetMaximum(),histo.GetEntries()*1e-5)
        fit.SetParLimits(4,0,histo.GetMaximum()*10)
        #histo.Fit(fit,"QOR")
        #histo.Fit(fit,"QOR")
        histo.Fit(fit,"ORB")
        err=fit.GetParError(self.desired)
        if math.isnan(err):
            result = (0,0)
        else:
            result = (fit.GetParameter(self.desired), err)        
        del fit
        return result


class TripleGaus(BaseMetric):
    def __init__(self, diseredParameter, minVal, maxVal,average=True):
        BaseMetric.__init__(self)
        self.range = [minVal, maxVal]
        assert diseredParameter in [0,1,2], "can only get parameter 0, 1 or 2 not '%s'"%desiredParameter
        self.desired = diseredParameter
        self.average = average
        
    def calculate(self, histo):
        from ROOT import TF1
        from math import sqrt
        fit = TF1("tgaus","[2]*TMath::Gaus(x,[0],[1])+[5]*TMath::Gaus(x,[3],[4])+[8]*TMath::Gaus(x,[6],[7])", *(self.range))
        fit.SetParameters(histo.GetMaximum(),0,histo.GetRMS()/10,histo.GetMaximum()/5,0,histo.GetRMS()/3,histo.GetMaximum()/5,0,histo.GetRMS())
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"QOR")
        histo.Fit(fit,"OR")
        if self.average:
            g1=TF1("g1","[2]*TMath::Gaus(x,[0],[1])",*(self.range))
            g1.SetParameters(fit.GetParameter(0),fit.GetParameter(1),fit.GetParameter(2))
            w1=g1.Integral(self.range[0],self.range[1])
            g1.SetParameters(fit.GetParameter(3),fit.GetParameter(4),fit.GetParameter(5))
            w2=g1.Integral(self.range[0],self.range[1])
            g1.SetParameters(fit.GetParameter(6),fit.GetParameter(7),fit.GetParameter(8))
            w3=g1.Integral(self.range[0],self.range[1])
            mean=(fit.GetParameter(self.desired)*w1+fit.GetParameter(3+self.desired)*w2+fit.GetParameter(6+self.desired)*w3)/(w1+w2+w3)
            err=sqrt(pow(fit.GetParError(self.desired)*w1,2)+pow(fit.GetParError(3+self.desired)*w2,2)+pow(fit.GetParError(6+self.desired)*w3,2))/(w1+w2+w3)
            del g1
            result(mean,err)
        else:
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


