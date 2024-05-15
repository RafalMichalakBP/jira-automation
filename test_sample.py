import warnings


def api_v1():
    warnings.warn(UserWarning('api v1, should use functions from v2'))
    return 1


def test_one():
    assert api_v1() == 1
    
def inc(x):
    return x + 1


def test_answer():
    assert inc(3) == 4
