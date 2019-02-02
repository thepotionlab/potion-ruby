#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require "test/unit"

require_relative "lib/test_constants"
require_relative "lib/test_javascript_constants"

require_relative "../lib/repla"
require_relative "../test/resources/lib/repla_tests.rb"
require Repla::Tests::TEST_HELPER_FILE


class TestViewJavaScript < Test::Unit::TestCase

  def setup
    @view = Repla::View.new
    @view.root_access_directory_path = TEST_ROOT_ACCESS_PATH
    @view.load_file(TEST_TEMPLATE_FILE)
  end

  def teardown
    @view.close
  end

  def test_resources
    # Testing jquery assures that `zepto.js` has been loaded correctly
    javascript = File.read(Repla::Tests::TEXTJQUERY_JAVASCRIPT_FILE)
    result = @view.do_javascript(javascript)

    test_javascript = File.read(Repla::Tests::TEXT_JAVASCRIPT_FILE)
    expected = @view.do_javascript(test_javascript)

    assert_equal(expected, result, "The result should equal expected result.")
  end

  def test_javascript_function_without_arguments
    result = @view.do_javascript_function(TEST_JAVASCRIPT_FUNCTION_WITHOUT_ARGUMENTS_NAME)
    assert_equal(result, TEST_JAVASCRIPT_FUNCTION_WITHOUT_ARGUMENTS_RESULT, "The result should equal the expected result.")
  end

  def test_javascript_function_with_arguments
    result = @view.do_javascript_function(TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_NAME, TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_STRING_ARGUMENTS)
    assert_equal(result, TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_STRING_RESULT, "The result should equal the expected result.")
  end

  def test_javascript_function_with_integer_argument
    result = @view.do_javascript_function(TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_NAME, TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_INTEGER_ARGUMENTS)
    assert_equal(result, TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_INTEGER_RESULT, "The result should equal the expected result.")
  end

  def test_javascript_function_with_float_argument
    result = @view.do_javascript_function(TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_NAME, TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_FLOAT_ARGUMENTS)
    assert_equal(result, TEST_JAVASCRIPT_FUNCTION_WITH_ARGUMENTS_FLOAT_RESULT, "The result should equal the expected result.")
  end

end
