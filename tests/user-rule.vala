class UserRuleTests : Kkc.TestCase {
    public UserRuleTests () {
        base ("UserRule");

        add_test ("creation", this.test_creation);
        add_test ("write", this.test_write);
    }

    public void test_creation () {
        var parent = Kkc.Rule.find_rule ("kana");
        assert (parent != null);

        var srcdir = Environment.get_variable ("srcdir");
        var rule = new Kkc.UserRule (parent, "test-user-rule", "test");
        assert (rule != null);
    }

    public void test_write () {
        var parent = Kkc.Rule.find_rule ("kana");
        assert (parent != null);

        var srcdir = Environment.get_variable ("srcdir");
        Kkc.UserRule rule;

        rule = new Kkc.UserRule (parent, "test-user-rule", "test");
        assert (rule != null);

        var event0 = new Kkc.KeyEvent.from_string ("C-a");
        rule.get_keymap (Kkc.InputMode.HIRAGANA).set (event0, "abort");
        rule.write (Kkc.InputMode.HIRAGANA);

        rule = new Kkc.UserRule (parent, "test-user-rule", "test");
        assert (rule != null);

        var event1 = new Kkc.KeyEvent.from_string ("C-a");
        var command = rule.get_keymap (Kkc.InputMode.HIRAGANA).lookup_key (event1);
        assert (command == "abort");
    }
}

int main (string[] args)
{
  Test.init (ref args);
  Kkc.init ();

  TestSuite root = TestSuite.get_root ();
  root.add_suite (new UserRuleTests ().get_suite ());

  Test.run ();

  return 0;
}