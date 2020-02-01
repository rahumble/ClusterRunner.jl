abstract type Dependency end
Base.Broadcast.broadcastable(dep::Dependency) = Ref(dep)

"""
    getalias(dep::Dependency)::String
    Returns the alias
"""
function getalias end
