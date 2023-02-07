def parsingCache(cacheKeys):
    result=[]
    for item in range(0,len(cacheKeys)):
        result.append(cacheKeys[item][1])
        
    return result


def getRunListFromCache(cache):

    import multiprocessing
    
    ntreads=20
    nitem=1000

    pool = multiprocessing.Pool(ntreads)
    
    result_list = pool.map(parsingCache, (list(cache.keys())[k:k+nitem] for k in range(0,len(cache.keys()),nitem))  )

    flat=[item for sublist in result_list for item in sublist]
    
    return flat
