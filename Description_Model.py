from gensim.models.doc2vec import Doc2Vec

model = Doc2Vec.load('./Description_doc2vec_model')

def Book_similarity(Title):
    result = model.docvecs.most_similar([model[Title]])
    return result[1][0]