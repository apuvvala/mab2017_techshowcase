import matlab.unittest.TestRunner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat
import matlab.unittest.plugins.ToFile

jenkins_workspace = getenv('WORKSPACE');
try
    % Pick up local tests
    suite = testsuite('/Users/Shared/Jenkins/Documents/MATLAB/work/mab2017/ci/cobe');
    
    coverageFile = fullfile(jenkins_workspace, 'coverage.xml');
    
    runner = TestRunner.withTextOutput;
    runner.addPlugin(CodeCoveragePlugin.forFolder('/Users/Shared/Jenkins/Documents/MATLAB/work/mab2017/ci/cobe/matlabcode',...    
        'Producing',CoberturaFormat(coverageFile)));
    results = runner.run(suite);
catch e
    disp(getReport(e, 'extended'));
    exit(1);
end