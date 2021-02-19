RSpec.describe FirstExisting do
  it "has a version number" do
    expect(FirstExisting::VERSION).not_to be nil
  end

  describe ".first_existing" do
    context "when given only existing arguments" do
      it "returns the first one" do
        expect(first_existing("string", true, 0, 15)).to eq "string"
      end
    end

    context "when given only nil arguments" do
      it "returns nil" do
        expect(first_existing(nil, nil, nil, nil)).to eq nil
      end
    end

    context "when given no arguments" do
      it "returns nil" do
        expect(first_existing).to eq nil
      end
    end

    context "when given mixed arguments" do
      context "when the first argument is existing" do
        it "returns it" do
          expect(first_existing("first", nil, nil, nil)).to eq "first"
        end
      end

      context "when the first argument is not existing" do
        context "when the second argument is existing" do
          it "returns the second argument" do
            expect(first_existing(nil, "second", nil, nil, nil)).to eq "second"
          end
        end

        context "when only the last argument is existing" do
          it "returns the last argument" do
            expect(first_existing(nil, nil, nil, nil, "last")).to eq "last"
          end
        end
      end
    end

    context "when given an empty string" do
      it "qualifies as existing" do
        expect(first_existing("")).to eq ""
      end
    end

    context "when given a blank string" do
      it "qualifies as existing" do
        expect(first_existing("\t ")).to eq "\t "
      end
    end

    context "when given false" do
      it "qualifies as existing" do
        expect(first_existing(false)).to eq false
      end
    end
  end
end
