import json
import os
from collections import OrderedDict

for y in range(2000, 2018):
    fname = "collections_" + str(y) + ".json"
    if os.path.isfile(fname):
        f = open(fname, "r")
        data = json.load(f, object_pairs_hook=OrderedDict)
        f.close()
        for key in data:
            plots = []
            for file in data[key]:
                print(file)
                if len(file) > 1:
                    name = os.path.commonprefix(file)
                    if '_' in name:
                        name = name[:name.rindex("_")+1]
                    suffix = os.path.commonprefix([f[::-1] for f in file])[::-1]
                    if '_' in suffix:
                        suffix = suffix[suffix.index("_"):]
                    if sum(len(x) - len(name) - len(suffix) for x in file) <= 14:
                        name += '[' + '/'.join(x.replace(name, '').replace(suffix, '') for x in file) + ']' + suffix
                    else:
                        name += '[' + file[0].replace(name, '').replace(suffix, '') + '/...]' + suffix
                else:
                    name = file[0]
                plots.append(OrderedDict([('name', name), ('corr', 'false'), ('files', file)]))
            data[key] = plots
        f = open(fname, 'w')
        json.dump(data, f)
        f.close()
