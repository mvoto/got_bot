defmodule HandlerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias GotBot.Handler
  doctest GotBot.Handler

  describe "perform" do
    test "calls valid house command" do
      use_cassette "got_house" do
        expected_house = "House Stark of Winterfell, from The North says Winter is Coming"
        assert Handler.perform("/house House Stark of Winterfell") == expected_house
      end
    end

    test "calls valid char command" do
      use_cassette "got_character" do
        expected_character = "Jon Snow, famous as Lord Commander of the Night's Watch"
        assert Handler.perform("/char Jon Snow") == expected_character
      end
    end

    test "returns gif when invalid entry" do
      assert Handler.perform("damn") == "https://weirwoodleviathan.files.wordpress.com/2015/11/unonothing.gif"
    end
  end
end
