import matlab.unittest.TestRunner
import matlab.unittest.plugins.XMLPlugin
import matlab.unittest.plugins.TAPPlugin
import matlab.unittest.plugins.ToFile

jenkins_workspace = getenv('WORKSPACE');
try
    % Pick up local tests
    suite = testsuite();
    %suite2 = testsuite(fullfile(matlabroot, 'test', 'toolbox', 'stm', 'matlabunit', 'testdata', 'testfolder'));
    %suite3 = testsuite(fullfile(matlabroot, 'test', 'toolbox', 'stm', 'matlabunit', 'testdata', 'testfolder', 'iterations'));
    %suite4 = testsuite(fullfile(matlabroot, 'test', 'toolbox', 'stm', 'matlabunit', 'testdata', 'testfolder', 'tags'));
    
    %suite = [suite1 suite2 suite3 suite4];
    
    xmlResultsFile = fullfile(jenkins_workspace, 'JUnitResults.xml');
    tapResultsFile = fullfile(jenkins_workspace, 'TAPResults.tap');
    reportFile = fullfile(jenkins_workspace, 'TestReport.pdf');
    
    runner = TestRunner.withTextOutput;
    runner.addPlugin(TAPPlugin.producingVersion13(ToFile(tapResultsFile)));
    runner.addPlugin(XMLPlugin.producingJUnitFormat(xmlResultsFile));
    runner.addPlugin(TestManagerReportPlugin(reportFile));
    
    results = runner.run(suite);
catch e
    disp(getReport(e, 'extended'));
    exit(1);
end
