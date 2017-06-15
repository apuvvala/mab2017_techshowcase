import matlab.unittest.TestRunner
import matlab.unittest.plugins.XMLPlugin
import matlab.unittest.plugins.TAPPlugin
import matlab.unittest.plugins.ToFile

% Pick up tests from Jenkins workspace - Jenkins job is configured to
% connect with github repo

jenkins_workspace = getenv('WORKSPACE');

% Define some variables for Autopilot demo
topModel    = 'TestAndVerificationAutopilotExample';
reqDoc      = 'RollAutopilotRequirements.txt';
rollModel   = 'RollAutopilotMdlRef';
testHarness = 'RollReference_Requirement1_3';
testFile    = 'AutopilotTestFile.mldatx';
harnessLink = 'http://localhost:31415/matlab/feval/rmiobjnavigate?arguments=[%22RollAutopilotMdlRef:urn:uuid:523e5d2d-bb86-43b2-a187-43c52a2bc174.slx%22,%22GIDa_3fe26a28_ee1e_4aff_b1cd_3303ca12539c%22]';

try
    suite = testsuite(jenkins_workspace);
    
    xmlResultsFile = fullfile(jenkins_workspace, 'JUnitResults.xml');
    tapResultsFile = fullfile(jenkins_workspace, 'TAPResults.tap');
    reportFile = fullfile(jenkins_workspace, 'TestReport.pdf');
    
    runner = TestRunner.withTextOutput;
    runner.addPlugin(TAPPlugin.producingOriginalFormat(ToFile(tapResultsFile)));
    runner.addPlugin(XMLPlugin.producingJUnitFormat(xmlResultsFile));
    runner.addPlugin(TestManagerReportPlugin(reportFile));
    
    results = runner.run(suite);
catch e
    disp(getReport(e, 'extended'));
    exit(1);
end