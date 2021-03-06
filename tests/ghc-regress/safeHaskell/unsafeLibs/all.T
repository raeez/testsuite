# Just do the normal way, SafeHaskell is all in the frontend
def f( opts ):
  opts.only_ways = ['normal']

setTestOpts(f)

test('Dep01', normal, compile, [''])
test('Dep02', normal, compile, [''])
test('Dep03', normal, compile, [''])
test('Dep04', normal, compile, [''])
test('Dep05', normal, compile, [''])
test('Dep06', normal, compile, [''])
test('Dep07', normal, compile, [''])
test('Dep08', normal, compile, [''])
test('Dep09', normal, compile, [''])
test('Dep10', normal, compile, [''])

test('BadImport01', normal, compile_fail, [''])
test('BadImport02', normal, compile_and_run, ['--make'])
test('BadImport03', normal, compile_fail, ['--make'])

